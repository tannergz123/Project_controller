import { createApp } from "vue";
import App from "./App.vue";
import store from "./store";
import router from "./router";
import axios from 'axios';
import "./assets/css/nucleo-icons.css";
import "./assets/css/nucleo-svg.css";
import ArgonDashboard from "./argon-dashboard";
import PrimeVue from 'primevue/config';
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import Dialog from 'primevue/dialog';
import InputText from 'primevue/inputtext';
import InputNumber from 'primevue/inputnumber';
import Dropdown from 'primevue/dropdown';
import 'primevue/resources/themes/bootstrap4-light-blue/theme.css';
import 'primevue/resources/primevue.min.css';
import 'primeicons/primeicons.css';
import Button from 'primevue/button';


const appInstance = createApp(App);

appInstance.component('DataTable', DataTable);
appInstance.component('Column', Column);
appInstance.component('Button', Button);
appInstance.component('Dialog', Dialog);
appInstance.component('InputNumber',InputNumber);
appInstance.component('InputText', InputText);
appInstance.component('Dropdown',Dropdown);
appInstance.use(store);
appInstance.use(router);
appInstance.use(ArgonDashboard);
appInstance.use(PrimeVue);
appInstance.config.globalProperties.axios=axios;
appInstance.config.globalProperties.$log = console.log
appInstance.mount("#app");

