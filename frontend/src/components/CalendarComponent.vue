<template>
  <div>
    <v-sheet height="6vh" class="d-flex align-center">
      <v-btn outlined small class="ma-4" @click="setToday">今日</v-btn>
      <v-btn icon @click="$refs.calendar.prev()">
        <v-icon>mdi-chevron-left</v-icon>
      </v-btn>
      <v-btn icon @click="$refs.calendar.next()">
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
      <v-toolbar-title>{{ title }}</v-toolbar-title>
    </v-sheet>
    <v-sheet height="100vh">
      <v-sheet height="94vh">
        <v-calendar
          ref="calendar"
          v-model="value"
          :events="events"
          @change="fetchEvents"
          locale="ja-JP"
          :day-format="(timestamp) => new Date(timestamp.date).getDate()"
          :month-format="
            (timestamp) => new Date(timestamp.date).getMonth() + 1 + '/'
          "
          @click:event="showEvent"
        ></v-calendar>
      </v-sheet>
    </v-sheet>

    <v-dialog :value="dialogMessage !== ''">
      <h1>{{ dialogMessage }}</h1>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import { mapGetters, mapActions } from "vuex";
import { format } from "date-fns";

export default {
  name: "CalendarComponent",
  data: () => ({
    value: new Date("2021/07/01"), // 表示する月を指定
    dialogMessage: "",
  }),
  computed: {
    ...mapGetters("events", ["events"]),
    title() {
      return format(this.value, "yyyy年 M月");
    },
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
    setToday() {
      this.value = format(new Date(), "yyyy/MM/dd");
    },
    showEvent({ event }) {
      // alert(event.name);
      this.dialogMessage = event.name;
    },
  },
};
</script>
