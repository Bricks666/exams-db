export interface Task {
  readonly ID: number;
  readonly ROOM_ID: number;
  readonly AUTHOR_ID: number;
  readonly GROUP_ID: number;
  readonly CONTENT: string;
  readonly STATUS: "READY" | "IN PROGRESS" | "NEED REVIEW" | "DONE";
  readonly CREATED_AT: string;
}
