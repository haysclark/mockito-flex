package org.mockito.impl {
import org.mockito.api.Answer;

public class ThrowingAnswer implements Answer {
    private var error:Error;

    public function ThrowingAnswer(error:Error) {
        this.error = error;
    }

    public function give():* {
        throw error;
    }

}
}