<template>
  <div>
    <h1>CalendarDetails</h1>
    <div v-for="event in events" :key="event.id">
      <h2>{{ event.name }}</h2>
      <p>start: {{ event.start }}</p>
      <p>end: {{ event.end }}</p>
      <p>description: {{ event.description }}</p>
    </div>

    <button type="submit" @click="fetchEvents()">fetchEvents</button>
  </div>
</template>

<script>
import axios from "axios";
import { mapGetters, mapActions } from "vuex";

export default {
  name: "CalendarDetails",
  data: () => ({
    events: [],
  }),
  computed: {
    ...mapGetters("events", ["events"]),
  },
  methods: {
    fetchEvents() {
      axios
        .get("http://127.0.0.1:3000/events")
        .then((response) => {
          this.events = response.data;
        })
        .catch((error) => {
          console.error(error);
        });
    },
    ...mapActions("events", ["fetchEvents"]),
  },
};
</script>
