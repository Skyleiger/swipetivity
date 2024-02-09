package io.swipetivity.core;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class SwipetivityCoreApplication {

    public static void main(String[] args) {
        SpringApplication.run(SwipetivityCoreApplication.class, args);
    }

}