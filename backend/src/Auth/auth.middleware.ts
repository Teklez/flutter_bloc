import { Injectable, NestMiddleware } from '@nestjs/common';

@Injectable()
export class AuthMiddleware implements NestMiddleware {
  use(req: any, res: any, next: () => void) {
    const authorizationHeader = req.headers['authorization'];

    if (authorizationHeader) {
      const token = authorizationHeader.substring('Bearer '.length);
      req.access_token = token;
    }

    next();
  }
}
