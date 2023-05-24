export default class rotaApi {
    constructor(
        rota_api = 'http://127.0.0.1:8000/api/usuarios',
        rota_criaUsers = 'http://127.0.0.1:8000/api'
    ) {
        this.rota_api = rota_api;
        this.rota_criaUsers = rota_criaUsers;
    }
}