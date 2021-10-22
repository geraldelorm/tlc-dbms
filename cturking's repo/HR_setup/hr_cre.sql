drop schema hr cascade;
create schema  if not exists hr;


CREATE TABLE hr.regions
    ( region_id      integer 
       CONSTRAINT  region_id_nn NOT NULL 
    , region_name    VARCHAR(25) 
    );


ALTER TABLE hr.regions
ADD  CONSTRAINT reg_id_pk
       		 PRIMARY KEY (region_id);


CREATE table hr.countries 
    ( country_id      CHAR(2) 
       CONSTRAINT  country_id_nn NOT NULL 
    , country_name    varchar(40) 
    , region_id       integer 
    , CONSTRAINT     country_c_id_pk 
        	     PRIMARY KEY (country_id) 
    ) 
  ; 

ALTER table hr.countries
ADD  CONSTRAINT countr_reg_fk
        	 FOREIGN KEY (region_id)
          	  REFERENCES hr.regions(region_id);

CREATE table hr.locations
    ( location_id    numeric(4)
    , street_address varchar(40)
    , postal_code    varchar(12)
    , city       varchar(30)
	CONSTRAINT     loc_city_nn  NOT NULL
    , state_province varchar(25)
    , country_id     CHAR(2)
    ,CONSTRAINT     location_id_pk 
        	     PRIMARY KEY (location_id)
    ) ;


ALTER table hr.locations
ADD  CONSTRAINT loc_c_id_fk
       		 FOREIGN KEY (country_id)
        	  REFERENCES hr.countries(country_id);


CREATE SEQUENCE hr.locations_seq
 START WITH     3300
 INCREMENT BY   100
 MAXVALUE       9900
 ;


CREATE table hr.departments
    ( department_id    numeric(4)
    , department_name  varchar(30)
	CONSTRAINT  dept_name_nn  NOT NULL
    , manager_id       numeric(6)
    , location_id      numeric(4)
    ) ;



ALTER table hr.departments
ADD  CONSTRAINT dept_id_pk
       		 PRIMARY KEY (department_id);
    
  ALTER table hr.departments
ADD  CONSTRAINT dept_loc_fk
       		 FOREIGN KEY (location_id)
        	  REFERENCES hr.locations (location_id);


CREATE SEQUENCE hr.departments_seq
 START WITH     280
 INCREMENT BY   10
 MAXVALUE       9990
;


CREATE table hr.jobs
    ( job_id         varchar(10)
    , job_title      varchar(35)
	CONSTRAINT     job_title_nn  NOT NULL
    , min_salary     numeric(6)
    , max_salary     numeric(6)
    ) ;



ALTER table hr.jobs
ADD CONSTRAINT job_id_pk
      		 PRIMARY KEY(job_id);


CREATE table hr.employees
    ( employee_id    numeric(6)
    , first_name     varchar(20)
    , last_name      varchar(25)
	 CONSTRAINT     emp_last_name_nn  NOT NULL
    , email          varchar(25)
	CONSTRAINT     emp_email_nn  NOT NULL
    , phone_integer   varchar(20)
    , hire_date      DATE
	CONSTRAINT     emp_hire_date_nn  NOT NULL
    , job_id         varchar(10)
	CONSTRAINT     emp_job_nn  NOT NULL
    , salary         numeric(8,2)
    , commission_pct numeric(2,2)
    , manager_id     numeric(6)
    , department_id  numeric(4)
    , CONSTRAINT     emp_salary_min
                     CHECK (salary > 0) 
    , CONSTRAINT     emp_email_uk
                     UNIQUE (email)
    ) ;




ALTER table hr.employees
ADD CONSTRAINT     emp_emp_id_pk
                     PRIMARY KEY (employee_id);
                    
ALTER table hr.employees
ADD	 CONSTRAINT     emp_dept_fk
                     FOREIGN KEY (department_id)
                      REFERENCES hr.departments (department_id);
					  
ALTER table hr.employees
ADD CONSTRAINT     emp_job_fk
                     FOREIGN KEY (job_id)
                      REFERENCES hr.jobs (job_id);

ALTER table hr.departments
ADD  CONSTRAINT dept_mgr_fk
      		 FOREIGN KEY (manager_id)
      		  REFERENCES hr.employees (employee_id);




CREATE SEQUENCE hr.employees_seq
 START WITH     207
 INCREMENT BY   1
;


CREATE table hr.job_history
    ( employee_id   numeric(6)
	 CONSTRAINT    jhist_employee_nn  NOT null
    , start_date    DATE
	CONSTRAINT    jhist_start_date_nn  NOT NULL
    , end_date      DATE
	CONSTRAINT    jhist_end_date_nn  NOT NULL
    , job_id        varchar(10)
	CONSTRAINT    jhist_job_nn  NOT NULL
    , department_id numeric(4)
    , CONSTRAINT    jhist_date_interval
                    CHECK (end_date > start_date)
    ) ;


ALTER table hr.job_history
ADD  CONSTRAINT jhist_emp_id_st_date_pk
      PRIMARY KEY (employee_id, start_date);
     
   ALTER table hr.job_history
ADD CONSTRAINT     jhist_job_fk
                     FOREIGN KEY (job_id)
                     REFERENCES hr.jobs;
                    
   ALTER table hr.job_history
ADD CONSTRAINT     jhist_emp_fk
                     FOREIGN KEY (employee_id)
                     REFERENCES hr.employees;
                    
 ALTER table hr.job_history
ADD CONSTRAINT     jhist_dept_fk
                     FOREIGN KEY (department_id)
                     REFERENCES hr.departments;


CREATE OR REPLACE VIEW emp_details_view
  (employee_id,
   job_id,
   manager_id,
   department_id,
   location_id,
   country_id,
   first_name,
   last_name,
   salary,
   commission_pct,
   department_name,
   job_title,
   city,
   state_province,
   country_name,
   region_name)
AS SELECT
  e.employee_id, 
  e.job_id, 
  e.manager_id, 
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  hr.employees e,
  hr.departments d,
  hr.jobs j,
  hr.locations l,
  hr.countries c,
  hr.regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id 
;

