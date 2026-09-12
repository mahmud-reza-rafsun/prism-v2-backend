/* eslint-disable @typescript-eslint/no-explicit-any */
import { Role } from "@prisma/client";

export interface IRequestUser {
  id: string;
  role: Role | string;
  email: string;
  distributionHouseId: string;
  regionId: string;
}

export interface ILoginUserPayload {
  email: string;
  password: string;
}

export interface IRegisterUserPayload {
  name: string;
  email: string;
  image: string;
  password: string;
}

export interface IChangePasswordPayload {
  currentPassword: string;
  newPassword: string;
}

export type NeedsVerification = {
  needsVerification: true;
  email: string;
};

export type SocialProvider =
  | "google"
  | "github"
  | "facebook"
  | "twitter"
  | "discord"
  | "linkedin"
  | "apple";

export type ISocialLoginSession = {
  user: { id: string };
};
