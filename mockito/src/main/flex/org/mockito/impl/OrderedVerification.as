package org.mockito.impl
{
import org.mockito.api.MethodSelector;
import org.mockito.api.MockVerificable;
import org.mockito.api.Verifier;

public class OrderedVerification implements MockVerificable
{
    private var verificable:MockVerificable;

    public function OrderedVerification(mockVerifier:MockVerificable)
    {
        this.verificable = mockVerifier;
    }

    public function verify(verifier:Verifier = null):MethodSelector
    {
        return verificable.verify(new InOrder(verifier || defaultVerifier));
    }

    public function get defaultVerifier():Verifier
    {
        return verificable.defaultVerifier;
    }
}
}