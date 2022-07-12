
<template>
  <div>
    <DataTable :value="projects" :paginator="true" :rows="10"
      paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
      :rowsPerPageOptions="[10, 20, 50]" responsiveLayout="scroll"
      currentPageReportTemplate="Showing {first} to {last} of {totalRecords}">
      <Column field="ProjectID" header="Project ID"></Column>
      <Column field="GSNumber" header="GS Number"></Column>
      <Column field="OrderDate" header="Order Date"></Column>
      <Column field="OligoDate" header="Oligo Date"></Column>
      <Column field="DeliverDate" header="Deliver Date"></Column>
      <Column field="ProjectStatus" header="Project Status"></Column>
      <Column field="Note" header="Note"></Column>
      <Column field="CompleteDate" header="Complete Date"></Column>
      <Column field="CustomerID" header="Customer ID"></Column>
      <template #paginatorstart>
        <Button type="button" icon="pi pi-refresh" class="p-button-text" />
      </template>
      <template #paginatorend>
        <Button type="button" icon="pi pi-cloud" class="p-button-text" />
      </template>
    </DataTable>
  </div>
</template>

<script>

export default {
  methods: {
    testLog() {
      this.console.log("test")
    }
  },
  name: "projects-table",
  components: {
  },
  data() {
    return {
      projects: []
    }
  },
  mounted() {
    this.axios.get('https://localhost:44397/api/project')
      .then(res => {
        this.projects = res.data;
      });
    // fetch('https://localhost:44397/api/project%27)
    //   .then(data => this.projects = data[0])
    //   .then(res => { res.json() })
    //   .then(console.log("this is projects", this.projects))
    //   .catch(console.error);
  }
}

</script>
!--https://localhost:44397/api/project--
