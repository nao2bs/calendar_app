<template>
  <div>
    <h1>Calendar</h1>
    <h1 class="text-h1">Calendar</h1>
    <!-- <ul>
      <li v-for="event in events" :key="event.id">
        {{ event.name }}
      </li>
    </ul> -->
    <v-list>
      <v-list-item v-for="event in events" :key="event.id">
        {{ event.name }}
      </v-list-item>
    </v-list>

    <v-btn type="submit" @click="fetchEvents()">fetchEvents</v-btn>
    <v-sheet height="100vh">
      <v-calendar
        v-model="value"
        :events="events"
        @change="fetchEvents"
      ></v-calendar>
    </v-sheet>
    <CalendarDetails />
  </div>
</template>

<script>
import axios from "axios";
import { mapGetters, mapActions } from "vuex";
import CalendarDetails from "./CalendarDetails.vue";
// import events from "@/store/modules/events";

export default {
  name: "CalendarComponent",
  components: {
    CalendarDetails,
  },
  data: () => ({
    value: new Date("2021/07/01"), // 表示する月を指定
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
          console.log(error);
        });
    },
    ...mapActions("events", ["fetchEvents"]),
  },
};
</script>
