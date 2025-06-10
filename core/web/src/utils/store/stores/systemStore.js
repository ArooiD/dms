import {makeAutoObservable} from "mobx";


export class SystemStore {
    IS_THEME_DARK = localStorage.getItem("d__theme") === 'dark';
    HEADER_TITLE = ''

    constructor() {
        makeAutoObservable(this)

        if (!localStorage.getItem("d__theme")) {
            this.IS_THEME_DARK = false;
            localStorage.setItem("d__theme", "light");
        }
    }

    toggleTheme = () => {
        this.IS_THEME_DARK = !this.IS_THEME_DARK;
    }
    setHeaderTitle = (value) => {
        this.HEADER_TITLE = value;
    }
}