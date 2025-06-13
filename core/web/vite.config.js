import {defineConfig} from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
    plugins: [react()],
    server: {
        host: true,
        allowedHosts: ['core.web','dv.istokmw.tech', 'localhost'],
        hot: true
    },
    build: {
        rollupOptions: {
            external: ['react', 'react-dom', 'react/jsx-runtime'],
            output: {
                globals: {
                    'react-dom': 'ReactDom',
                    react: 'React',
                    'react/jsx-runtime': 'ReactJsxRuntime',
                },
            },
        }
    }
})
