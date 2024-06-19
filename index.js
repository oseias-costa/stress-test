import mysql from "mysql2";
import { faker } from "@faker-js/faker";
import axios from "axios";
import { SingleBar } from "cli-progress";

export const connection = mysql.createPool({
  host: "127.0.0.1",
  port: "3316",
  user: "root",
  password: "mysqlroot",
});

async function index() {
  const rootId = process.env.ROOT_ID_MYSQL;
  const createRootGraph = process.env.ROOT_ID_DGRAPH;

  const bar = new SingleBar({
    format: 'Loading | {bar} | {percentage}% | ETA: {eta}s | {value}/{total}'
  })

  const numbersOfOrganizations = 30
  const numbersOfEnvironments = 4

  bar.start(numbersOfOrganizations - 1, 0)

  for (let i = 0; i < numbersOfOrganizations; i++) {
    bar.update(i)
    const organization = await insertResource(2);

    const organizationDgraph = await insertResourceDgraph(
      organization.fakeName,
      "ORGANIZATION",
      createRootGraph
    );

    const [rows] = await connection.promise().query(
      `
        INSERT INTO graph.ResourcesInheritance (parentUuid, childUuid) VALUES(?, ?);`,
      [rootId, organization.fakeUuid]
    );

    for (let j = 0; j < numbersOfEnvironments; j++) {
      const enviroment = await insertResource(4);

      const environmentDgraph = await insertResourceDgraph(
        enviroment.fakeName,
        "ENVIRONMENT",
        organizationDgraph.data.id
      );

      const [row] = await connection.promise().query(
        `
        INSERT INTO graph.ResourcesInheritance (parentUuid, childUuid) VALUES(?, ?);`,
        [organization.fakeUuid, enviroment.fakeUuid]
      );
    }
  }
  bar.stop()
  console.log('Complete Inserts')
}

async function insertResource(kindId) {
  const fakeUuid = faker.string.uuid();
  const fakeName = faker.company.name();

  const [rows] = await connection.promise().query(
    `
        INSERT INTO graph.Resource (uuid, resourceKindId, name) VALUES(?, ?, ?);`,
    [fakeUuid, kindId, fakeName]
  );

  return { fakeUuid, fakeName };
}

async function insertResourceDgraph(name, type, parentId) {
  const res = await axios({
    url: process.env.API_DGRAPH_ENDPOINT,
    method: "post",
    data: {
      resourceName: name,
      resourceType: type,
      resourceParentId: parentId,
    },
  });

  return res
}

index();
