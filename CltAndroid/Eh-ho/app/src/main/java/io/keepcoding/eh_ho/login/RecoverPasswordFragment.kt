package io.keepcoding.eh_ho.login

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import io.keepcoding.eh_ho.R
import io.keepcoding.eh_ho.data.RecoverPasswordModel
import io.keepcoding.eh_ho.inflate
import kotlinx.android.synthetic.main.fragment_recover_password.*
import kotlinx.android.synthetic.main.fragment_recover_password.inputEmailRecoverPassword
import kotlinx.android.synthetic.main.fragment_recover_password.labelSignInRecoverPassword
import java.lang.IllegalArgumentException

class RecoverPasswordFragment : Fragment() {

    var recoverPasswordInteractionListener: RecoverPasswordInteractionListener?
            = null

    override fun onAttach(context: Context) {
        super.onAttach(context)

        if (context is RecoverPasswordInteractionListener)
            recoverPasswordInteractionListener = context
        else
            throw IllegalArgumentException("Context doesn't implement ${RecoverPasswordInteractionListener::class.java.canonicalName}")
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return container?.inflate(R.layout.fragment_recover_password)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        buttonRecoverPassword.setOnClickListener {
            if(isFormValid()) {
                val model = RecoverPasswordModel(
                    inputEmailRecoverPassword.text.toString()
                )
                recoverPasswordInteractionListener?.onRecoverPassword(model)
            } else {
                showErrors()
            }
        }

        labelSignInRecoverPassword.setOnClickListener {
            recoverPasswordInteractionListener?.onGoToSignIn()
        }
    }

    private fun showErrors() {
        if(inputEmailRecoverPassword.text.isEmpty())
            inputEmailRecoverPassword.error = getString(R.string.error_empty)
    }

    private fun isFormValid() = inputEmailRecoverPassword.text.isNotEmpty()

    override fun onDetach() {
        super.onDetach()
        this.recoverPasswordInteractionListener = null
    }

    interface RecoverPasswordInteractionListener {
        fun onGoToSignIn()
        fun onRecoverPassword(recoverPasswordModel: RecoverPasswordModel)
    }
}