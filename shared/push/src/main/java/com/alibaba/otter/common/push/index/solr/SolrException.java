package com.alibaba.otter.common.push.index.solr;

import org.apache.commons.lang.exception.NestableRuntimeException;

public class SolrException extends NestableRuntimeException {
    private static final long serialVersionUID = 2680820522662343759L;
    private String errorCode;
    private String errorDesc;

    public SolrException(String errorCode) {
        super(errorCode);
    }

    public SolrException(String errorCode, Throwable cause) {
        super(errorCode, cause);
    }

    public SolrException(String errorCode, String errorDesc) {
        super(errorCode + ":" + errorDesc);
    }

    public SolrException(String errorCode, String errorDesc, Throwable cause) {
        super(errorCode + ":" + errorDesc, cause);
    }

    public SolrException(Throwable cause) {
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
