package io.keepcoding.eh_ho.data

import android.net.Uri
import io.keepcoding.eh_ho.BuildConfig

object ApiRoutes {

    fun signIn(username: String) =
        uriBuilder()
            .appendPath("users")
            .appendPath("${username}.json")
            .build()
            .toString()

    fun signUp() =
        uriBuilder()
            .appendPath("users")
            .build()
            .toString()

    fun recoverPassword() =
        uriBuilder()
            .appendPath("session")
            .appendPath("forgot_password")
            .build()
            .toString()


    fun getTopics() =
        uriBuilder()
            .appendPath("latest.json")
            .build()
            .toString()

    fun getPosts(topicId: String) =
        uriBuilder()
            .appendPath("t")
            .appendPath(topicId)
            .appendPath("posts.json")
            .build()
            .toString()

    fun createTopic() =
        uriBuilder()
            .appendPath("posts.json")
            .build()
            .toString()

    fun createPost() =
        uriBuilder()
            .appendPath("posts.json")
            .build()
            .toString()

    private fun uriBuilder() =
        Uri.Builder()
            .scheme("https")
            .authority(BuildConfig.DiscourseDomain)

}