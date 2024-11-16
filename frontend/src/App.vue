<template>
  <v-app>
    <v-main>
      <CalendarComponent />
    </v-main>
  </v-app>
</template>

<script>
import CalendarComponent from "./components/CalendarComponent.vue";

export default {
  name: "App",

  components: {
    CalendarComponent,
  },

  data: () => ({
    //
  }),
};
</script>
