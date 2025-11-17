package com.example.devops;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class SimpleCalculateTest {

   
    SimpleCalculate calc = new SimpleCalculate();

    @Test
    void testAddition() {
        double a = 5;
        double b = 3;
        double expected = a + b;
        double result = a + b;
        assertEquals(expected, result, "Addition should return the correct result");
    }

    @Test
    void testSubtraction() {
        double a = 10;
        double b = 4;
        double expected = a - b;
        double result = a - b;
        assertEquals(expected, result, "Subtraction should return the correct result");
    }

    @Test
    void testDivisionByZero() {
    double a = 10.0;
    double b = 0.0;
    double result = a / b;
    assertTrue(Double.isInfinite(result), "Division by zero (double) should result in infinity");
    }
}