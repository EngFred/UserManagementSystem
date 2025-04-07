package com.usermanagementsys.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
    public static String formatCurrentUserDate(Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat("MMMM dd, yyyy 'at' hh:mm a");
        return formatter.format(date);
    }

    public static String formatOtherUserDate(Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat("MMMM dd, yyyy");
        return formatter.format(date);
    }
}
