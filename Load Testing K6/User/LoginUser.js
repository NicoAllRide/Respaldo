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
    'https://stage.allrideapp.com/api/v1/login/email',
    '{\r\n   "username":"nicolas+endauto@allrideapp.com",\r\n   "password":"Equilibriozen123#"\r\n}',
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
  

  // Password Recovery
  response = http.post('https://stage.allrideapp.com/')

  // Automatically added sleep
  sleep(1)
}
