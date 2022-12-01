export interface User {
  readonly ID: number;
  readonly LOGIN: string;
  readonly PASSWORD: string;
  readonly PHOTO: string | null;
}
