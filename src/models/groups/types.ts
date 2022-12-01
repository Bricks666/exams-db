import { HEX } from "@/types/common";

export interface Group {
  readonly ID: number;
  readonly ROOM_ID: number;
  readonly CREATOR_ID: number;
  readonly NAME: string;
  readonly MAIN_COLOR: HEX;
  readonly SECONDARY_COLOR: HEX;
}
