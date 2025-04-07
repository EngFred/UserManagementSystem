package com.usermanagementsys.util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;

//ommy000000@gmail.com
public class CloudinaryUtils {
    private static final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dlserf8zr",
            "api_key", "477246522677297",
            "api_secret", "WLOYsrh8vPdt7t86hSruAwJQGtE"
    ));

    public static String uploadProfileImage(Part filePart) {
        File tempFile = null;
        try {
            // Create a temporary file
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // safe filename
            tempFile = File.createTempFile("upload_", "_" + fileName);

            // Write uploaded file content to the temporary file
            try (InputStream input = filePart.getInputStream();
                 OutputStream output = Files.newOutputStream(tempFile.toPath())
            ) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }

            // Upload file to Cloudinary
            Map<?, ?> uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());

            // Return the uploaded image URL
            return uploadResult.get("secure_url").toString();
        } catch (Exception e) {
            System.err.println("Error uploading profile image: " + e);
            return null;
        } finally {
            // Clean up temporary file
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
        }
    }

}