package io.swipetivity.core.dto;

import lombok.Data;
import org.springframework.http.HttpStatus;

import java.time.Instant;

@Data
public class ErrorResponse {

    private final Instant timestamp;
    private final HttpStatus status;
    private final String message;

    public ErrorResponse(HttpStatus status, Throwable throwable) {
        this.timestamp = Instant.now();
        this.status = status;
        this.message = throwable.getLocalizedMessage();
    }

}