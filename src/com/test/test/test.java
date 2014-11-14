package com.test.test;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import android.text.method.ScrollingMovementMethod;

public class test extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        /* Create a TextView and set its content.
         * the text is retrieved by calling a native
         * function.
         */
        TextView  tv = new TextView(this);
        tv.setMovementMethod(ScrollingMovementMethod.getInstance());
        tv.setText(resultFromJNI());
        setContentView(tv);
    }

    /* A native method that is implemented by the
     * 'cpuinfo' native library, which is packaged
     * with this application.
     */
    public native String  resultFromJNI();

    /* this is used to load the 'cpuinfo' library on application
     * startup. The library has already been unpacked into
     * /data/data/magiccode.test.cpuinfo/lib/libvcvt.so at
     * installation time by the package manager.
     */
    static {
        System.loadLibrary("test");
    }
}
