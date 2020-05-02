# Schedjulia

Schedjulia is an appointment scheduling script written in Julia.

## Overview

Schedjulia uses the concept of appointments with required duration and attendees, crossed with the attendees' availabilities to produce a satisfying schedule.

### Prerequisites

- [Julia](https://julialang.org/)
- An automated conversion system between your calendar/spreadsheet and the `.txt` files here is recommended.
  - This way, the integer units representing time and be converted to real time expressions.

### Files

- Schedjulia uses integer units to represent time. Of course, these units can be scaled to represent different timeslots of the time period.
- Appointments to be scheduled include their unit duration and attendees, stored in `appointments.txt`.

  ```txt
  <duration>|<attendee>,<attendee>,...
  ...
  ```

- Availabilities of individual attendees are stored in `availability.txt`.

  ```txt
  <attendee>|<timeslot>,<timeslot>,...
  ...
  ```

- **Note**: Follow the above templates or supplied example files as closely as possible, and do not include newlines at the end of the files.

## Usage

After loading `appointments.txt` and `availability.txt`, run the script.

```sh
julia schedjulia.jl
```

## Development/Pages

- [**Homepage**](https://leglesslamb.gitlab.io/post/schedjulia)
- [**GitLab**](https://gitlab.com/leglesslamb/schedjulia)
  - Working issues and Merge Requests (MRs) are reviewed.
  - Bug reports and feature requests are preferred.
- [**GitHub (Mirror)**](https://github.com/leglesslamb/schedjulia)
  - Bug reports and feature requests are accepted.
