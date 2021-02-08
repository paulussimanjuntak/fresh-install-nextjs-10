FROM jorgehortelano/node-sharp AS base
WORKDIR /base
COPY package*.json ./
RUN npm install
COPY . .

FROM base AS build
ENV NODE_ENV=production
WORKDIR /build
COPY --from=base /base ./
RUN npm run build

FROM jorgehortelano/node-sharp AS production
ENV NODE_ENV=production
WORKDIR /app
COPY --from=build /build ./
RUN npm install next

EXPOSE 3000
CMD npm run start
