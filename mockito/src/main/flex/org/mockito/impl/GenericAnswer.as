package org.mockito.impl {
import org.mockito.api.Answer;

public class GenericAnswer implements Answer {

    private var answer:Function;
    
    public function GenericAnswer(answer:Function) {
        this.answer = answer;
    }

    public function give():* {
        return answer();
    }

    }
}