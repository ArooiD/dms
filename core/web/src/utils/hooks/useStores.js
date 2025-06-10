import {useContext} from "react";
import {StoreContext} from "../store/StoreContext/StoreContext.jsx";


export const useStores = () => {
    return useContext(StoreContext);
};