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

    <v-dialog :value="event !== null" @click:outside="closeDialog" width="600">
      <div v-if="event !== null">
        <v-card class="pb-12">
          <v-card-actions class="d-flex justify-end pa-2">
            <v-btn icon @click="closeDialog">
              <v-icon size="20px">mdi-close</v-icon>
            </v-btn>
          </v-card-actions>
          <v-card-title>
            <v-row>
              <v-col cols="2" class="d-flex justify-center align-center">
                <v-icon size="20px">mdi-square</v-icon>
              </v-col>
              <v-col class="d-flex align-center">
                {{ event.name }}
              </v-col>
            </v-row>
          </v-card-title>
          <v-card-text>
            <v-row>
              <v-col cols="2" class="d-flex justify-center align-center">
                <v-icon size="20px">mdi-clock-time-three-outline</v-icon>
              </v-col>
              <v-col class="d-flex align-center">
                {{ event.start.toLocaleString() }} ~
                {{ event.end.toLocaleString() }}
              </v-col>
            </v-row>
          </v-card-text>
          <v-card-text>
            <v-row>
              <v-col cols="2" class="d-flex justify-center align-center">
                <v-icon size="20px">mdi-card-text-outline</v-icon>
              </v-col>
              <v-col class="d-flex align-center">
                {{ event.description || "no description" }}
              </v-col>
            </v-row>
          </v-card-text>
        </v-card>
      </div>
      <EventDetailDialog v-if="event !== null" />
    </v-dialog>
  </div>
</template>
<script>
import { mapGetters, mapActions } from "vuex";
import { format } from "date-fns";
import EventDetailDialog from "./EventDetailDialog.vue";

export default {
  name: "CalendarComponent",
  components: {
    EventDetailDialog,
  },
  data: () => ({
    value: new Date("2021/07/01"), // 表示する月を指定
    // todo
    // value: format(new Date(), "yyyy/MM/dd"),
  }),
  computed: {
    ...mapGetters("events", ["events", "event"]),
    title() {
      return format(this.value, "yyyy年 M月");
    },
  },
  methods: {
    ...mapActions("events", ["fetchEvents", "setEvent"]),
    setToday() {
      this.value = format(new Date(), "yyyy/MM/dd");
    },
    showEvent({ event }) {
      this.setEvent(event);
    },
    closeDialog() {
      this.setEvent(null);
    },
  },
};
</script>
