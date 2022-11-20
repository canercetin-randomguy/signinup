package main

import (
	"fmt"
	"net/http"

	"github.com/AlyRagab/golang-user-registration/controllers"
	"github.com/AlyRagab/golang-user-registration/models"
	"github.com/julienschmidt/httprouter"
)

// Error Handling
func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}

// HTTP 404 NotFound
func notfound(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusNotFound)
	fmt.Fprint(w, "404 Page not found")
}

var psqlInfo string

func AfterLogin(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	fmt.Fprintf(w, "If you see this text, then you are signed up. I am too lazy to develop anything related to frontend.")
}
func main() {
	var (
		host   = "mysql"
		port   = 3306
		dbuser = "cansu"
		password = "1234"
		dbname = "users"
	)

	psqlInfo = fmt.Sprintf("%s:%s@tcp(%s:%d)/%s", dbuser,password, host, port, dbname)
	us, err := models.NewUserService(psqlInfo)
	if err != nil {
		panic(err)
	}
	defer us.Close()

	// _ = controllers.NewStatic()        // Parsing static templates
	usersC := controllers.NewUsers(us) // Handling User Controller

	r := httprouter.New()
	r.GET("/home", AfterLogin)
	r.GET("/", usersC.New)
	r.GET("/signup", usersC.New)
	r.POST("/signup", usersC.Create)
	r.GET("/cookietest", usersC.CookieTest)
	r.NotFound = http.HandlerFunc(notfound)

	// healthz endpoint
	// h, _ := health.New()
	// h.Register(health.Config{
	// 	Name:      "postgres-check",
	// 	Timeout:   time.Second * 5,
	// 	SkipOnErr: true,
	// 	Check: healthPg.New(healthPg.Config{
	// 		DSN: psqlInfo,
	// 	}),
	// })

	r.GET("/healthz", func(w http.ResponseWriter, r *http.Request, p httprouter.Params) {
		err = us.Ping()
		if err != nil {
			fmt.Fprintf(w, "Not Healthy Response %d", http.StatusInternalServerError)
			return
		} else {
			fmt.Fprintf(w, "Healthy Response %d", http.StatusOK)
		}
	})
	fmt.Println("Starting Server on 0.0.0.0:4545")
	err = http.ListenAndServe(":4545", r)
	if err != nil {
		panic(err)
	}
}
