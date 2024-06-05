package main

import (
	"context"
	"fmt"
	"time"

	"cloud.google.com/go/spanner"
)

func main() {
	ctx := context.Background()
	for i := 1; i < 10000; i++ {
		t := time.Now()
		client, err := spanner.NewClient(ctx, "projects/test/instances/instance0/databases/database0")
		if err != nil {
			panic(err)
		}

		stmt := spanner.Statement{SQL: `SELECT count(1) FROM table`}
		err = client.Single().Query(ctx, stmt).Do(
			func(row *spanner.Row) error {
				return nil
			})
		if err != nil {
			panic(err)
		}
		client.Close()

		if i%100 == 1 {
			fmt.Println(time.Since(t))
		}
	}
}
