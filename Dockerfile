FROM node:20.11.1-alpine

WORKDIR /app

# Copy package.json so that package manager commands can be used.
COPY package.json package-lock.json ./
COPY prisma ./prisma

# if package change then run install
RUN npm install

# Copy the rest of the source files into the image.
COPY . .

# Run the build script.
RUN npx prisma generate
RUN npm run build

# Expose the port that the application listens on.
EXPOSE 3000

# Run the application.
CMD ["node", "dist/index.js"]
