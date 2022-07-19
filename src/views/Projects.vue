<template>
  <div class="py-4 container-fluid">
    <div class="mt-4 row">
      <div class="col-12">
        <projects-table />
      </div>
    </div>
  </div>
</template>

<script>
import ProjectsTable from "./Tables/ProjectsTable.vue";

export default {
  name: "Projects",
  components: {
    ProjectsTable
  },
  data() {
    return {
      displayModal:false,
      valueFN:null
 
    };
  },
  methods:{
    openDialog(){
      this.displayModal=true;
    }
  }
  
};
</script>
