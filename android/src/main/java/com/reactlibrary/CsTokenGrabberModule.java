// CsTokenGrabberModule.java

package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import android.content.Context;
import android.content.SharedPreferences;

public class CsTokenGrabberModule extends ReactContextBaseJavaModule {
    private static final String PREFERENCE_TAG = "_preferences";
    private static final String USER_TOKEN = "user_token";

    private SharedPreferences sharedPreferences;

    public CsTokenGrabberModule(ReactApplicationContext reactContext) {
        super(reactContext);
        sharedPreferences = reactContext.getSharedPreferences(reactContext.getPackageName() + PREFERENCE_TAG, Context.MODE_PRIVATE);
    }

    @Override
    public String getName() {
        return "CsTokenGrabber";
    }

    private String getString(String key) {
        return sharedPreferences.getString(key, null);
    }

    private Boolean deleteKey(String key) {
        return sharedPreferences.edit().remove(key).commit();
    }

    @ReactMethod
    public void authToken(Promise promise) {
        try{
            promise.resolve(getString(USER_TOKEN));
        }catch (Exception e){
            promise.reject("CsTokenGrabberError", e);
        }
    }

    @ReactMethod
    public  void deleteAuthToken(Promise promise) {
        Boolean result = deleteKey(USER_TOKEN);
        promise.resolve(result);
    }
}
