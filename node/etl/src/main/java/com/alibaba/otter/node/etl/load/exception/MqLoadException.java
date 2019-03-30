package com.alibaba.otter.node.etl.load.exception;

import org.apache.commons.lang.exception.NestableRuntimeException;

public class MqLoadException extends NestableRuntimeException {

    private static final long serialVersionUID = 2680820522662343759L;
    private String            errorCode;
    private String            errorDesc;

    public MqLoadException(String errorCode){
        super(errorCode);
    }

    public MqLoadException(String errorCode, Throwable cause){
        super(errorCode, cause);
    }

    public MqLoadException(String errorCode, String errorDesc){
        super(errorCode + ":" + errorDesc);
    }

    public MqLoadException(String errorCode, String errorDesc, Throwable cause){
        super(errorCode + ":" + errorDesc, cause);
    }

    public MqLoadException(Throwable cause){
        super(cause);
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorDesc() {
        return errorDesc;
    }

    @Override
    public Throwable fillInStackTrace() {
        return this;
    }
}
