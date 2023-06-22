package com.example.barcodescanner

import android.content.Intent
import android.database.SQLException
import android.database.sqlite.SQLiteDatabase
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.barcodescanner.R
import com.example.barcodescanner.feature.tabs.BottomTabsActivity
import java.io.IOException
import android.widget.AutoCompleteTextView
import android.content.SharedPreferences
import android.content.Context
import android.widget.ArrayAdapter



class MainActivity : AppCompatActivity() {
        private lateinit var sharedPreferences: SharedPreferences
        override fun onCreate(savedInstanceState: Bundle?) {
                super.onCreate(savedInstanceState)
                setContentView(R.layout.activity_main)

                val userEmail: EditText = findViewById(R.id.user_email)
                val userPass: EditText = findViewById(R.id.user_pass)
                val button: Button = findViewById(R.id.button_log_in)

                var mDBHelper: DatabaseHelper
                var mDb:SQLiteDatabase

                mDBHelper = DatabaseHelper(this)

                try {
                        mDBHelper.updateDataBase()
                } catch (mIOException: IOException) {
                        throw Error("UnableToUpdateDatabase")
                }

                try {
                        mDb = mDBHelper.getWritableDatabase()
                } catch (mSQLException: SQLException) {
                        throw mSQLException
                }
                sharedPreferences = getSharedPreferences("MyPrefs", Context.MODE_PRIVATE)
                userEmail.setText(sharedPreferences.getString("email", ""))
                userPass.setText(sharedPreferences.getString("password", ""))
                button.setOnClickListener{
                        val email = userEmail.text.toString().trim()
                        val pass = userPass.text.toString().trim()

                        if(email == "" || pass == "")
                                Toast.makeText(this, "Не все поля заполнены", Toast.LENGTH_LONG).show()
                        else {
                                val result = mDb.rawQuery("SELECT * FROM students WHERE email = '$email' AND pass = '$pass'",null)
                                if (result.moveToFirst())
                                {
                                        val editor = sharedPreferences.edit()
                                        editor.putString("email", email)
                                        editor.putString("password", pass)
                                        editor.apply()

                                        Toast.makeText(this, "Пользователь авторизован", Toast.LENGTH_SHORT).show()
                                        val intent = Intent(this, BottomTabsActivity::class.java)
                                        startActivity(intent)
                                        userEmail.text.clear()
                                        userPass.text.clear()
                                } else
                                        Toast.makeText(this, "Неверный email или пароль, попробуйте заново.", Toast.LENGTH_SHORT).show()
                        }
                }
        }
}