export default class ProjectService {

    getAllProjects() {
        this.axios.get('https://localhost:44397/api/project')
        .catch(error => {
            this.errorMessage = error.message;
            console.error("There was an error!", error);
          });
    }
}