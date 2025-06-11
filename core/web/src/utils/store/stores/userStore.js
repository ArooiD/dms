import {makeAutoObservable} from "mobx";
import {jwtDecode} from "jwt-decode";


export class UserStore {
    IS_AUTHORIZED = !!localStorage.getItem("d__token") && localStorage.getItem("d__token").length > 0

    constructor() {
        makeAutoObservable(this)

        if (!localStorage.getItem("d__token")) {
            this.IS_AUTHORIZED = false;
            localStorage.setItem("d__token", "");
        }
    }

    logout = () => {
        localStorage.removeItem("d__token");
        this.IS_AUTHORIZED = false;
    }
    login = (token) => {
        localStorage.setItem("d__token", typeof token === 'string' ? token : '')
        this.IS_AUTHORIZED = true;
    }
    getToken = () => {
        const token = localStorage.getItem("d__token")
        if (token) {
            return token
        } else {
            this.logout()
            return ''
        }
    }
    getExpirationTime = () => {
        const token = localStorage.getItem("d__token")

        if (token) {
            const result = jwtDecode(token)

            return parseInt(`${result.exp}000`) ?? 0
        } else return 0
    }
}