-- CreateEnum
CREATE TYPE "ROLE" AS ENUM ('ADMIN', 'EMPLOYEE');

-- CreateEnum
CREATE TYPE "AGE_RANGE" AS ENUM ('AGE_3_4', 'AGE_5_6', 'AGE_7_8');

-- CreateEnum
CREATE TYPE "STORY_THEME" AS ENUM ('FRIENDSHIP', 'HONESTY', 'COURAGE', 'SHARING', 'EMPATHY', 'RESPECT', 'BEDTIME', 'FEAR', 'SCHOOL');

-- CreateEnum
CREATE TYPE "QUESTION_TYPE" AS ENUM ('COMPREHENSION', 'EMOTION', 'CREATIVITY');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" "ROLE" NOT NULL DEFAULT 'EMPLOYEE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stories" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "coverImage" TEXT,
    "content" TEXT NOT NULL,
    "readingTime" INTEGER NOT NULL,
    "ageRange" "AGE_RANGE" NOT NULL,
    "theme" "STORY_THEME" NOT NULL,
    "moral" TEXT,
    "published" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "story_questions" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "type" "QUESTION_TYPE" NOT NULL,
    "storyId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "story_questions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coloring_pages" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "storyId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "coloring_pages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coloring_images" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "imageUrl" TEXT NOT NULL,
    "svgUrl" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,
    "supportOnlinePainting" BOOLEAN NOT NULL DEFAULT false,
    "coloringPageId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "coloring_images_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "stories_slug_key" ON "stories"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "coloring_pages_slug_key" ON "coloring_pages"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "coloring_pages_storyId_key" ON "coloring_pages"("storyId");

-- AddForeignKey
ALTER TABLE "story_questions" ADD CONSTRAINT "story_questions_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES "stories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "coloring_pages" ADD CONSTRAINT "coloring_pages_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES "stories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "coloring_images" ADD CONSTRAINT "coloring_images_coloringPageId_fkey" FOREIGN KEY ("coloringPageId") REFERENCES "coloring_pages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
