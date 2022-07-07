<template>
  <div class="card mb-4">
    <div class="card-header pb-0">
      <h6>Projects table</h6>
    </div>
    <div class="card-body px-0 pt-0 pb-2">
      <div class="table-responsive p-0">
        <table class="table align-items-center justify-content-center mb-0">
          <thead>
            <tr>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Project ID</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">GSNumber</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">OrderDate</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Order
                Date</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Oligo
                Date</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Delivery
                Date</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Project
                Status</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Note</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">
                Completion Date</th>
              <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Customer
                ID</th>
            </tr>
          </thead>

          <tbody>
              <tr v-for="proj in projects" v-bind:key="proj" v-bind:dep="proj">
                <td>{{proj.ProjectID}} </td>
                <td>{{proj.GSNumber}} </td>
                <td>{{proj.OrderDate}} </td>
                <td>{{proj.OligoDate}} </td>
                <td>{{proj.DeliverDate}} </td>
                <td>{{proj.ProjectStatus}} </td>
                <td>{{proj.Note}} </td>
                <td>{{proj.CompleteDate}} </td>
                <td>{{proj.CustomerID}} </td>
              </tr>
            
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  name: "projects-table",
  data(){
        return{
          projects:[]
        }
  },
  methods:{
      refreshData(){
          axios.get('https://localhost:44397/api/project')
          .then((response)=>{
            this.projects=response.data;
          });
      }
  },
  mounted:function(){
    this.refreshData();
  }
}

</script>
<!--https://localhost:44397/api/project-->
