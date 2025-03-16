package com.gandummas.sparepartmanagementsystem_flutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Bundle
import android.provider.ContactsContract.Intents.Insert.ACTION
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val channel = "com.gandummas.sms_flutter.channel.process.data"
    private var methodChannel: MethodChannel? = null

    private var dwVersion = ""
    private val extraProfileName = "SMS_Flutter"

    // DataWedge Extras
    private val extraGetVersionInfo = "com.symbol.datawedge.api.GET_VERSION_INFO"
    private val extraCreateProfile = "com.symbol.datawedge.api.CREATE_PROFILE"
    private val extraKeyApplicationName = "com.symbol.datawedge.api.APPLICATION_NAME"
    private val extraKeyNotificationType = "com.symbol.datawedge.api.NOTIFICATION_TYPE"
    private val extraSoftScanTrigger = "com.symbol.datawedge.api.SOFT_SCAN_TRIGGER"
    private val extraResultNotification = "com.symbol.datawedge.api.NOTIFICATION"
    private val extraRegisterNotification = "com.symbol.datawedge.api.REGISTER_FOR_NOTIFICATION"
    private val extraUnregisterNotification = "com.symbol.datawedge.api.UNREGISTER_FOR_NOTIFICATION"
    private val extraSetConfig = "com.symbol.datawedge.api.SET_CONFIG"

    private val extraResultNotificationType = "NOTIFICATION_TYPE"
    private val extraKeyValueScannerStatus = "SCANNER_STATUS"
    private val extraKeyValueProfileSwitch = "PROFILE_SWITCH"
    private val extraKeyValueConfigurationUpdate = "CONFIGURATION_UPDATE"
    private val extraKeyValueNotificationStatus = "STATUS"
    private val extraKeyValueNotificationProfileName = "PROFILE_NAME"
    private val extraSendResult = "SEND_RESULT"

    private val extraEmpty = ""

    private val extraResultGetVersionInfo = "com.symbol.datawedge.api.RESULT_GET_VERSION_INFO"
    private val extraResult = "RESULT"
    private val extraResultInfo = "RESULT_INFO"
    private val extraCommand = "COMMAND"

    // DataWedge Actions
    private val actionDatawedge = "com.symbol.datawedge.api.ACTION"
    private val actionResultNotification = "com.symbol.datawedge.api.NOTIFICATION_ACTION"
    private val actionResult = "com.symbol.datawedge.api.RESULT_ACTION"

    // private variables
    private val bRequestSendResult = false
    val logTag = "SMS_Flutter"

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    private fun createProfile(): String {
        val profileName = extraProfileName

        // Send DataWedge intent with extra to create profile
        // Use CREATE_PROFILE: http://techdocs.zebra.com/datawedge/latest/guide/api/createprofile/
        actionDatawedge.sendDataWedgeIntentWithExtra(extraCreateProfile, profileName)

        // Configure created profile to apply to this app
        val profileConfig = Bundle()
        profileConfig.putString("PROFILE_NAME", extraProfileName)
        profileConfig.putString("PROFILE_ENABLED", "true")
        profileConfig.putString(
            "CONFIG_MODE",
            "CREATE_IF_NOT_EXIST"
        ) // Create profile if it does not exist

        // Configure barcode input plugin
        val barcodeConfig = Bundle()
        barcodeConfig.putString("PLUGIN_NAME", "BARCODE")
        barcodeConfig.putString("RESET_CONFIG", "true") //  This is the default
        val barcodeProps = Bundle()
        barcodeConfig.putBundle("PARAM_LIST", barcodeProps)
        profileConfig.putBundle("PLUGIN_CONFIG", barcodeConfig)

        // Associate profile with this app
        val appConfig = Bundle()
        appConfig.putString("PACKAGE_NAME", packageName)
        appConfig.putStringArray("ACTIVITY_LIST", arrayOf("*"))
        profileConfig.putParcelableArray("APP_LIST", arrayOf(appConfig))
        profileConfig.remove("PLUGIN_CONFIG")

        // Apply configs
        // Use SET_CONFIG: http://techdocs.zebra.com/datawedge/latest/guide/api/setconfig/
        actionDatawedge.sendDataWedgeIntentWithExtra(extraSetConfig, profileConfig)

        // Configure intent output for captured data to be sent to this app
        val intentConfig = Bundle()
        intentConfig.putString("PLUGIN_NAME", "INTENT")
        intentConfig.putString("RESET_CONFIG", "true")
        val intentProps = Bundle()
        intentProps.putString("intent_output_enabled", "true")
        intentProps.putString("intent_action", resources.getString(R.string.activity_intent_filter_action))
        intentProps.putString("intent_delivery", "2")
        intentConfig.putBundle("PARAM_LIST", intentProps)
        profileConfig.putBundle("PLUGIN_CONFIG", intentConfig)
        actionDatawedge.sendDataWedgeIntentWithExtra(extraSetConfig, profileConfig)
        return "Created profile.  Check DataWedge app UI."
    }

    // Toggle soft scan trigger from UI onClick() event
    // Use SOFT_SCAN_TRIGGER: http://techdocs.zebra.com/datawedge/latest/guide/api/softscantrigger/
    private fun toggleSoftScanTrigger() {
        actionDatawedge.sendDataWedgeIntentWithExtra(extraSoftScanTrigger, "TOGGLE_SCANNING")
    }

    // Create filter for the broadcast intent
    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    private fun registerReceivers() {
        Log.d(logTag, "registerReceivers()")
        val filter = IntentFilter()
        filter.addAction(actionResultNotification) // for notification result
        filter.addAction(actionResult) // for error code result
        filter.addCategory(Intent.CATEGORY_DEFAULT) // needed to get version info

        // register to received broadcasts via DataWedge scanning
        filter.addAction(resources.getString(R.string.activity_intent_filter_action))
        filter.addAction(resources.getString(R.string.activity_action_from_service))
        registerReceiver(myBroadcastReceiver, filter, RECEIVER_EXPORTED)
    }

    // Unregister scanner status notification
    private fun unRegisterScannerStatus() {
        Log.d(logTag, "unRegisterScannerStatus()")
        val b = Bundle()
        b.putString(extraKeyApplicationName, packageName)
        b.putString(extraKeyNotificationType, extraKeyValueScannerStatus)
        val i = Intent()
        i.setAction(ACTION)
        i.putExtra(extraUnregisterNotification, b)
        this.sendBroadcast(i)
    }

    private fun setDecoder(decoders: Map<String, Boolean>): String {
        val code128Value: String = decoders["code128"].toString()
        val code39Value: String = decoders["code39"].toString()
        val ean13Value: String = decoders["ean13"].toString()
        val upcaValue: String = decoders["upca"].toString()

        // Main bundle properties
        val profileConfig = Bundle()
        profileConfig.putString("PROFILE_NAME", extraProfileName)
        profileConfig.putString("PROFILE_ENABLED", "true")
        profileConfig.putString("CONFIG_MODE", "UPDATE") // Update specified settings in profile

        // PLUGIN_CONFIG bundle properties
        val barcodeConfig = Bundle()
        barcodeConfig.putString("PLUGIN_NAME", "BARCODE")
        barcodeConfig.putString("RESET_CONFIG", "true")

        // PARAM_LIST bundle properties
        val barcodeProps = Bundle()
        barcodeProps.putString("scanner_selection", "auto")
        barcodeProps.putString("scanner_input_enabled", "true")
        barcodeProps.putString("decoder_code128", code128Value)
        barcodeProps.putString("decoder_code39", code39Value)
        barcodeProps.putString("decoder_ean13", ean13Value)
        barcodeProps.putString("decoder_upca", upcaValue)

        // Bundle "barcodeProps" within bundle "barcodeConfig"
        barcodeConfig.putBundle("PARAM_LIST", barcodeProps)
        // Place "barcodeConfig" bundle within main "profileConfig" bundle
        profileConfig.putBundle("PLUGIN_CONFIG", barcodeConfig)

        // Create APP_LIST bundle to associate app with profile
        val appConfig = Bundle()
        appConfig.putString("PACKAGE_NAME", packageName)
        appConfig.putStringArray("ACTIVITY_LIST", arrayOf("*"))
        profileConfig.putParcelableArray("APP_LIST", arrayOf(appConfig))
        actionDatawedge.sendDataWedgeIntentWithExtra(extraSetConfig, profileConfig)
        // Simplify the toast below

        return """
            In profile $extraProfileName, the selected decoders are being set:
            Code128=$code128Value
            Code39=$code39Value
            EAN13=$ean13Value
            UPCA=$upcaValue
            """.trimIndent()
    }

    private val myBroadcastReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val action = intent.action
            intent.extras
            Log.d(logTag, "DataWedge Action:$action")

            // Get DataWedge version info
            if (intent.hasExtra(extraResultGetVersionInfo)) {
                val versionInfo = intent.getBundleExtra(extraResultGetVersionInfo)
                dwVersion = versionInfo!!.getString("DATAWEDGE")!!
                methodChannel?.invokeMethod("displayDWVersion", dwVersion)
                Log.i(logTag, "DataWedge Version: $dwVersion")
            }
            if (action == resources.getString(R.string.activity_intent_filter_action)) {
                //  Received a barcode scan
                try {
                    displayScanResult(intent)
                } catch (e: Exception) {
                    //  Catch error if the UI does not exist when we receive the broadcast...
                }
            } else if (action == actionResult) {
                // Register to receive the result code
                if (intent.hasExtra(extraResult) && intent.hasExtra(extraCommand)) {
                    val command = intent.getStringExtra(extraCommand)
                    val result = intent.getStringExtra(extraResult)
                    var info = ""
                    if (intent.hasExtra(extraResultInfo)) {
                        val resultInfo = intent.getBundleExtra(extraResultInfo)
                        val keys = resultInfo!!.keySet()
                        for (key in keys) {
                            val `object` = resultInfo.getObject(key)
                            if (`object` is String) info += "$key: $`object`\n"
                            else if (`object` is Array<*> && `object`.isArrayOf<String>())
                                for (code in `object`) info += "$key: $code\n"
                        }
                        Log.d(
                            logTag, """
                                Command: $command
                                Result: $result
                                Result Info: $info
                                """.trimIndent()
                        )
                        methodChannel?.invokeMethod("showToast",
                            "Error Resulted. Command:$command\nResult: $result\nResult Info: $info")
                    }
                }
            } else if (action == actionResultNotification) {
                if (intent.hasExtra(extraResultNotification)) {
                    val extras = intent.getBundleExtra(extraResultNotification)
                    val notificationType = extras!!.getString(extraResultNotificationType)
                    if (notificationType != null) {
                        when (notificationType) {
                            extraKeyValueScannerStatus -> {
                                // Change in scanner status occurred
                                val displayScannerStatusText =
                                    extras.getString(extraKeyValueNotificationStatus) +
                                            ", profile: " + extras.getString(
                                        extraKeyValueNotificationProfileName
                                    )
                                //Toast.makeText(getApplicationContext(), displayScannerStatusText, Toast.LENGTH_SHORT).show();
//                                val lblScannerStatus =
//                                    findViewById<View>(R.id.lblScannerStatus) as TextView
//                                lblScannerStatus.text = displayScannerStatusText
                                Log.i(logTag, "Scanner status: $displayScannerStatusText")
                            }

                            extraKeyValueProfileSwitch -> {}
                            extraKeyValueConfigurationUpdate -> {}
                        }
                    }
                }
            }
        }
    }

    private fun displayScanResult(initiatingIntent: Intent) {
        // store decoded data
        val decodedData = initiatingIntent.getStringExtra(resources.getString(R.string.datawedge_intent_key_data))
        // store decoder type
        val decodedLabelType = initiatingIntent.getStringExtra(resources.getString(R.string.datawedge_intent_key_label_type))
        // pack the data into a Map
        val scanResult: Map<String, String> = mapOf(
            "scanData" to decodedData.toString(),
            "scanLabelType" to decodedLabelType.toString()
        )
        methodChannel?.invokeMethod("displayScanResult", scanResult)
    }

    private fun String.sendDataWedgeIntentWithExtra(extraKey: String, extras: Bundle) {
        val dwIntent = Intent()
        dwIntent.setAction(this)
        dwIntent.putExtra(extraKey, extras)
        if (bRequestSendResult) dwIntent.putExtra(extraSendResult, "true")
        this@MainActivity.sendBroadcast(dwIntent)
    }

    private fun String.sendDataWedgeIntentWithExtra(extraKey: String, extraValue: String) {
        val dwIntent = Intent()
        dwIntent.setAction(this)
        dwIntent.putExtra(extraKey, extraValue)
        if (bRequestSendResult) dwIntent.putExtra(extraSendResult, "true")
        this@MainActivity.sendBroadcast(dwIntent)
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun onResume() {
        super.onResume()
        registerReceivers()
    }

//    override fun onPause() {
//        super.onPause()
//        unregisterReceiver(myBroadcastReceiver)
//        unRegisterScannerStatus()
//    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GeneratedPluginRegistrant.registerWith(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)

        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "setDecoder" -> call.arguments<Map<String, Boolean>>()?.let { result.success(setDecoder(it)) }
                "createProfile" -> result.success(createProfile())
                "toggleSoftScan" -> { toggleSoftScanTrigger(); result.success(true); }
                "registerReceiver" -> {
                    try {
                        val b = Bundle()
                        b.putString(extraKeyApplicationName, packageName)
                        b.putString(
                            extraKeyNotificationType,
                            "SCANNER_STATUS"
                        ) // register for changes in scanner status
                        actionDatawedge.sendDataWedgeIntentWithExtra(extraRegisterNotification, b)

                        registerReceivers()

                        // Get DataWedge version
                        // Use GET_VERSION_INFO: http://techdocs.zebra.com/datawedge/latest/guide/api/getversioninfo/
                        actionDatawedge.sendDataWedgeIntentWithExtra(
                            extraGetVersionInfo,
                            extraEmpty
                        ) // must be called after registering BroadcastReceiver

                        result.success(true)
                    } catch (e: Exception) {
                        result.error("Error", e.message, e)
                    }
                }
                "unregisterReceiver" -> {
                    try {
                        unregisterReceiver(myBroadcastReceiver)
                        unRegisterScannerStatus()

                        result.success(true)
                    } catch (e: Exception) {
                        result.error("Error", e.message, e)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun Bundle.getObject(key: String): Any? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getParcelable(key, Object::class.java)
        } else {
            @Suppress("DEPRECATION") // use deprecated API on older platforms
            get(key)
        }
    }
}
