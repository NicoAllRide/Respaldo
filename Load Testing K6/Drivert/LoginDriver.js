import { sleep, check } from 'k6'
import http from 'k6/http'

export const options = {
  cloud: {
    distribution: { 'amazon:us:ashburn': { loadZone: 'amazon:us:ashburn', percent: 100 } },
    apm: [],
  },
  thresholds: {},
  scenarios: {
    Scenario_1: {
      executor: 'per-vu-iterations',
      gracefulStop: '30s',
      vus: 10,
      iterations: 10,
      maxDuration: '1m',
      exec: 'scenario_1',
    },
  },
}

export function scenario_1() {
  let response

  // Login Driver
  response = http.post(
    'https://stage.allrideapp.com/api/v1/pb/provider/login',
    '{\r\n  "email": "nicolas+conductorrdda@allrideapp.com",\r\n  "password": "Equilibriozen123#",\r\n  "device": {\r\n    "lang": "es",\r\n    "token": "f83OnTZMQFSS6u6d7Ug3RT:APA91bFcIgD1tsP-C5CZoEP1Ir_kUJEYbq2F_ielNH4ey6rb5cDWwrTClK8ofb9uLUfiUqNxhBqD__l1kDBawpE5B6qhqKZJDZHSp_zAdF5fQrU098TuzM7dYqHkYRKIXI0IjW2VurYF",\r\n    "manufacturer": "motorola",\r\n    "model": "moto g71 5G",\r\n    "appVersion": "108",\r\n    "brand": "null"\r\n  }\r\n}',
    {
      headers: {
        'content-type': 'application/json',
      },
    }
  )
  check(response, {
    'status equals 200': response => response.status.toString() === '200',
    'status equals 404': response => response.status.toString() === '404',
    'status equals 429': response => response.status.toString() === '429',
  })

  // Automatically added sleep
  sleep(1)
}
