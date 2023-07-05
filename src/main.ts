import { ClassSerializerInterceptor, ValidationPipe } from '@nestjs/common';
import { NestFactory, Reflector } from '@nestjs/core';
import { urlencoded, json } from 'express';

import { AppModule } from './app.module';
import { SERVER_PORT } from './app.config';

async function bootstrap() {
  // Create app instance
  const app = await NestFactory.create(AppModule, {
    cors: true,
  });

  app.use(json({ limit: '50mb' }));
  app.use(urlencoded({ extended: true, limit: '50mb' }));

  // Add validation pipe
  app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));

  app.useGlobalInterceptors(
    new ClassSerializerInterceptor(app.get(Reflector), {
      enableImplicitConversion: true,
    }),
  );

  // Start the server
  await app.listen(process.env.SERVER_PORT ?? SERVER_PORT);
  console.log(`Application is running on: ${await app.getUrl()}`);
}
bootstrap();
