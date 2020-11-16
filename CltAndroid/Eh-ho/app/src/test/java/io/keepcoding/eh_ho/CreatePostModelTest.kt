package io.keepcoding.eh_ho

import io.keepcoding.eh_ho.data.CreatePostModel
import org.junit.Assert.assertEquals
import org.junit.Test

class CreatePostModelTest {
    @Test
    fun toJson_isCorrect() {
        val model = CreatePostModel(Integer(1), "Content")
        val json = model.toJson()

        assertEquals(Integer(1), json.get(("topic_id")))
        assertEquals("Content", json.get("raw"))
    }

}
