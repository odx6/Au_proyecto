import { defineConfig } from "vite";
import laravel from "laravel-vite-plugin";
import vue from "@vitejs/plugin-vue";

export default defineConfig({
    plugins: [
        vue(),
        laravel({
            input: ["resources/css/app.css", "resources/js/app.js"],
            refresh: true,
        }),
    ],
    build: {
        outDir: "public/build",
        emptyOutDir: true,
        sourcemap: false, // Disable source maps for security
        minify: "terser", // Minify JS & CSS
        rollupOptions: {
            output: {
                manualChunks: undefined, // Optimize chunk splitting
            },
        },
    },
});
