/* eslint-disable @typescript-eslint/no-explicit-any */
import { ZodObject } from "zod";
import { Request, Response, NextFunction } from "express";

const validateRequest = (schema: ZodObject<any>) => {
    return (req: Request, res: Response, next: NextFunction) => {
        schema.parse({
            body: req.body,
            query: req.query,
            params: req.params,
        });

        next();
    };
};

export default validateRequest;
