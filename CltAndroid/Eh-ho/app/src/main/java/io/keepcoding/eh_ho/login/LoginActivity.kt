package io.keepcoding.eh_ho.login

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import com.google.android.material.snackbar.Snackbar
import io.keepcoding.eh_ho.R
import io.keepcoding.eh_ho.data.*
import io.keepcoding.eh_ho.topics.TopicsActivity
import io.keepcoding.eh_ho.isFirstTimeCreated
import kotlinx.android.synthetic.main.activity_login.*

class LoginActivity : AppCompatActivity(),
    SignInFragment.SignInInteractionListener,
    SignUpFragment.SignUpInteractionListener,
    RecoverPasswordFragment.RecoverPasswordInteractionListener {

    val signUpFragment = SignUpFragment()
    val signInFragment = SignInFragment()
    val recoverPasswordFragment = RecoverPasswordFragment()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        if (isFirstTimeCreated(savedInstanceState)) {
            checkSession()
        }

    }

    private fun checkSession() {
        if (UserRepo.isLogged(this.applicationContext)) {
            showTopics()
        } else {
            onGoToSignIn()
        }
    }

    fun printMessage() {
        this
    }

    private fun showTopics() {
        val intent: Intent = Intent(this, TopicsActivity::class.java)
        startActivity(intent)
        finish()
    }

    override fun onGoToSignIn() {
        supportFragmentManager.beginTransaction().replace(R.id.fragmentContainer, signInFragment)
            .commit()
    }

    override fun onSignIn(signInModel: SignInModel) {
        enableLoading()

        UserRepo.signIn(this.applicationContext,
            signInModel,
            { showTopics()},
            { error ->
                enableLoading(false)
                handleError(error)
            }
        )
    }

    private fun handleError(error: RequestError) {
        if (error.messageResId != null)
            Snackbar.make(container, error.messageResId, Snackbar.LENGTH_LONG).show()
        else if(error.message != null)
            Snackbar.make(container, error.message, Snackbar.LENGTH_LONG).show()
        else
            Snackbar.make(container, R.string.error_default, Snackbar.LENGTH_LONG).show()

    }

    override fun onGoToSignUp() {
        supportFragmentManager.beginTransaction().replace(R.id.fragmentContainer, signUpFragment)
            .commit()
    }

    override fun onSignUp(signUpModel: SignUpModel) {
        enableLoading()
        UserRepo.signUp(this.applicationContext,
            signUpModel,
            {
                enableLoading(false)
                Snackbar.make(container, R.string.message_sign_up, Snackbar.LENGTH_LONG).show()
                // Revisar respuesta del servidor
            },
            {
                enableLoading(false)
                handleError(it)
            }
        )
    }

    override fun onGoToRecoverPassword() {
               supportFragmentManager.beginTransaction().replace(R.id.fragmentContainer, recoverPasswordFragment)
            .commit()
    }

    override fun onRecoverPassword(recoverPasswordModel: RecoverPasswordModel) {
        enableLoading()

        UserRepo.recoverPassword(this.applicationContext,
            recoverPasswordModel,
            {
                enableLoading(false)
                Snackbar.make(container, R.string.message_recover_password, Snackbar.LENGTH_LONG).show()
                // Revisar respuesta del servidor
            },
            {
                enableLoading(false)
                handleError(it)
            }
        )
    }

    private fun enableLoading(enabled: Boolean = true) {
        if(enabled) {
            fragmentContainer.visibility = View.INVISIBLE
            viewLoading.visibility = View.VISIBLE
        } else {
            fragmentContainer.visibility = View.VISIBLE
            viewLoading.visibility = View.INVISIBLE
        }
    }
}

// 1. Definición de interfaz a partir de una clase
class Listener : View.OnClickListener {
    override fun onClick(view: View?) {
        Toast.makeText(view?.context, "Welcome to Eh-Ho", Toast.LENGTH_SHORT).show()
    }
}

