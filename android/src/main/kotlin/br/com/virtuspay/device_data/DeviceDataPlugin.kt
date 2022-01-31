package br.com.virtuspay.device_data

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger

import android.app.ActivityManager
import java.io.File
import java.io.IOException

class DeviceDataPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var applicationContext: Context
  private lateinit var channel : MethodChannel
  private lateinit var activityManager : ActivityManager

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    onAttachedToEngine(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
  }

  private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger) {
      this.applicationContext = applicationContext
      channel = MethodChannel(messenger, "device_data")
      channel.setMethodCallHandler(this)
      activityManager = applicationContext.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "available_memory_size" -> {
        val memInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memInfo)
        result.success(memInfo.availMem.toDouble()/(1024*1024*1024))
      }
      "total_memory_size" -> {
        val memInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memInfo)
        result.success(memInfo.totalMem.toDouble()/(1024*1024*1024))
      }
      "cpu_model" -> {
          result.success("${readCpu()}");
      }
      "cpu_cores" -> {
          result.success(Runtime.getRuntime().availableProcessors())
      }
      else -> {
          result.notImplemented()
      }
  }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun readCpu():String{

    val sb = StringBuffer();

    if (File("/proc/cpuinfo").exists()) {
        try {
            val file = File("/proc/cpuinfo")

            file.bufferedReader().forEachLine {
                if(it.split(":")[0].contains("Hardware")){
                    sb.append(it.split(":")[1]);
                }
            }

        } catch (e: IOException) {
            e.printStackTrace();
        }
    }
    return sb.toString();
}
}
