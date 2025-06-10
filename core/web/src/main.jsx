import {StrictMode} from 'react'
import {createRoot} from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import {BrowserRouter} from "react-router-dom";
import {StoreProvider} from "./utils/store/StoreProvider/StoreProvider";

createRoot(document.getElementById('root')).render(
    <StrictMode>
        <StoreProvider>
            <BrowserRouter>
                <App/>
            </BrowserRouter>
        </StoreProvider>
    </StrictMode>,
)
