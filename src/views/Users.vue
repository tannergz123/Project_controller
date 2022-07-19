<template>
  <div class="py-4 container-fluid">

    <div class="mt-4 row">

        
    </div>

    <div class="mt-4 row">
      <div class="col-12">
        <users-table />
      </div>
    </div>
  </div>
</template>

<script>
import UsersTable from "./Tables/UsersTable.vue";

export default {
  name: "Users",
  components: {
    UsersTable
  },
  data() {
    return {
      displayModal:false,
      valueFN:null,
      valueLN:null,
      valueRID:null,
      valueTID:null,
      valueLGNF:null,
      valueEM:null,
      valuePSWD:null
    };
  },

  methods: {
        openDialog() {
            this.displayModal = true;
        },
        userCreation(){
          console.log("console log:"+this.valueFN);
          //this.valueFN=;
        }
  }
};
</script>
