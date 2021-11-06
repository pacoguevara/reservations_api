# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

  > ruby-2.6.3

- Database creation

  > rails db:migrate

- Database initialization

  > bundle exec rails db:seed

- How to run the test suite

  > bundle exec rspec

- API Documentation
  > lib/Reservations API.postman_collection.json

# Proposal

- Call the customers API to find the customer by email
  `/customers?email=example@email.com`

  The response should have the customer information and the vehicles that he/she has registred.

  ```
   [
     {
       "id": 1,
       "email": "fguevara@mail.com",
       "name": "Francisco Guevara",
       "created_at": "2021-11-06T09:23:21.400Z",
       "updated_at": "2021-11-06T09:23:21.400Z",
       "vehicles": [
           {
               "id": 1,
               "make": "Mazda",
               "model": "CX-3",
               "year": 2015,
               "customer_id": 1,
               "created_at": "2021-11-06T09:23:21.403Z",
               "updated_at": "2021-11-06T09:23:21.403Z"
           }
       ]
     }
   ]
  ```

From there we can use that information to get the `customer_id` and the `vehicle_id`

## Create new reservation

In order to create a new reservation, we need to send the vehicle information that includes the customer information.

`localhost:3000/reservations`

- New reservation for a new customer with a new vehicle

```
  {
    reservation: {
      service_id: service.id,
      start_time: Time.now,
      end_time: Time.now+1,
      vehicle_attributes: {
        make: "Mazda",
        model: "CX5",
        year: 2015,
        customer_attributes: {
          name: "Francisco Guevara",
          email: "fguevara@mail.com"
        }
      }
    }
  }
```

- New reservation for a current customer with a new vehicle

```
  {
    reservation: {
      service_id: service.id,
      start_time: Time.now,
      end_time: Time.now+1,
      vehicle_attributes: {
        make: "Mazda",
        model: "CX5",
        year: 2015,
        customer_id: customer.id
      }
    }
  }
```

- New reservation for a current customer and same vehicle

```
  {
    reservation: {
      service_id: service.id,
      start_time: Time.now,
      end_time: Time.now+1,
      vehicle_id: vehicle.id
    }
  }
```
